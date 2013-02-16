require 'singleton'

class ReportingRelationshipsTree
  include Singleton

  attr_accessor :update_requests, :top_node_id

  @worker = nil
  @update_requests = nil
  @top_node_id = nil

  def get_direct_reporting_relationships_tree(employee)
    Rails.logger.info "using employee #{employee.inspect} to get tree"
    get_tree(employee)
  end

  def touch_direct_reporting_relationships_tree
    update_cache
  end

  def set_top_node_id(id)
    @top_node_id = id
  end

  # http://therealadam.com/2012/06/19/getting-started-with-ruby-concurrency-using-two-simple-classes/
  def initialize
    @update_requests = Queue.new
    @top_node_id = 685 # BOD by default; will need to set this in a config file, i think.
    Rails.logger.info "reporting_relationships_tree singleton initialized with top node id of #{@top_node_id}."
    @worker = Thread.new do
      loop do
        @update_requests.pop
        Rails.logger.info "popped update request..."
        tree = rebuild_tree
        Rails.cache.write(:tree, tree) # replace stale tree with new tree.
      end
    end
  end

  private

  # update the json reporting hierarchy for self
  # http://blog.plataformatec.com.br/2009/09/how-to-avoid-dog-pile-effect-rails-app/
  def update_cache
    Rails.logger.info "pushing update request: queue length: #{@update_requests.length}"
    @update_requests << "update_request #{Time.now.to_f}"
  end

  # https://devcenter.heroku.com/articles/caching-strategies
  # http://api.rubyonrails.org/classes/ActiveSupport/Cache/Store.html#method-i-fetch
  def get_tree(employee)
    tree = Rails.cache.fetch(:tree) do
      tree = rebuild_tree
    end
    # Rails.logger.info "tree built: #{tree}"
    # then, recurse to find the node i want to start with
    dn = {"id"=>0, "name"=>"", "size"=>0, "children"=> [tree]} # container node for the find method (todo: make loop smarter so i dont need a container)
    node = find_by_id(dn, get_tree_top_id(employee))
    node
  end

  def rebuild_tree
    Rails.logger.info "in rebuilding tree."
    tt = Employee.find_by_id(@top_node_id)
    Rails.logger.info "building with #{tt.inspect}"
    start = Time.now.to_f
    tn = to_node tt, 0  # arthur
    Rails.logger.info "done building. #{Time.now.to_f - start} secs"
    tn
  end

  def find_by_id(node, find_this="")
    Rails.logger.info "searching for #{find_this} in tree..."
    if node.is_a?(Hash)
      node.each do |k,v|
        if v.is_a?(Array)
          v.each do |elm|
            Rails.logger.info "-> #{elm['id']} == #{find_this}?"
            if elm["id"] == find_this
              return elm      # THIS IS WHAT I WANT!
            else
              result = find_by_id(elm, find_this)
              return result if result
            end
          end
        end
      end
    end
    nil
  end

  # if i have no supervisor, return me
  def get_tree_top_id(employee)
    if employee.supervisor_relationships.empty?
      Rails.logger.debug "no supervisor, returning my id: #{employee.id}"
      employee.id
    else
      sup = employee.supervisor_relationships.reject{|sr| sr.dotted == true}.first

      Rails.logger.debug "supervisor, returning id: #{sup.supervisor_id}"
      sup.supervisor_id
    end
  end

  # look into: http://mikehillyer.com/articles/managing-hierarchical-data-in-mysql/
  def to_node(n, i)
    #i = i + 1
    #Rails.logger.info "#{n.full_name} #{i}"
    #Rails.logger.info "direct subs: #{n.direct_subordinates}"
    {
      "id" => n.id,
      "name" => n.full_name,
      "size" => 1,
      "children" => n.direct_subordinates.empty? ? "" : n.direct_subordinates.map { |c| to_node c, i }
    }
  end


end
