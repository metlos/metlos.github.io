require 'bootstrap-sass'
require 'pager'

Awestruct::Extensions::Pipeline.new do
  extension Awestruct::Extensions::Posts.new '/posts', :posts
  extension Awestruct::Extensions::Paginator.new( :posts, '/posts/index', :per_page => 10 )
  extension Awestruct::Extensions::Indexifier.new
  # Indexifier *must* come before Atomizer
  extension Awestruct::Extensions::Atomizer.new :posts, '/blog.atom', 
      :feed_title => "Reinventing The Wheel"
  extension Awestruct::Extensions::Tagger.new :posts, '/posts/index', 'posts/tags',
          :per_page=> 10
  #extension Awestruct::Extensions::TagCloud.new :posts, 'posts/tags/index.html', :layout => 'base', :title => "Tags"  
  extension Awestruct::Extensions::Disqus.new()
  extension Awestruct::Extensions::Pager.new 'pager'
  
  helper Awestruct::Extensions::GoogleAnalytics
end
