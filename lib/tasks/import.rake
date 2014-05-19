@archive_directories = [
  '2004',
  '2005',
  '2006',
  '2007',
  '2008',
  '2009',
  '2013',
]

@ignorable = [
  '.',
  '..',
  'index.html',
]

def get_files(base_path)
  Dir.chdir(base_path)
  files = []
  @archive_directories.each do |year|
    months = Dir.entries(year).select {|x| not @ignorable.include? x}
    months.each do |month|
      posts = Dir.entries("#{year}/#{month}").select {|x| not @ignorable.include? x}
      posts.each do |post|
        files.push("#{base_path}/#{year}/#{month}/#{post}")
      end
    end
  end
  return files
end

def parse_date(crap)
  crap = crap.to_s
  crap = crap.gsub(/.+on/, '')
  crap = crap.strip
  DateTime.parse(crap)
end

def get_content(file)
  html = Nokogiri::HTML(File.open(file))
  document = {
    title: html.css('h2#archive-title').children.to_s,
    slug: file[/([a-z0-9_]+)\.html$/].gsub(/\.html/, ''),
    body: html.css('div.entry-content div.entry-body').children.to_s,
    author: html.css('p.entry-footer span.post-footers a').inner_html,
    date: parse_date(html.css('p.entry-footer span.post-footers').children.to_s),
  }
end

task :import => :environment do
  files = get_files('/Users/stephen/Source/wick.fomps.net')

  documents = []
  files.each do |file|
    documents.push(get_content(file))
  end

  #documents.each do |document|
  #  puts document[:title]
  #end

  documents.each do |document|
    post = Post.new
    post.title = document[:title]
    post.slug = document[:slug]
    post.body = document[:body]
    post.created_at = document[:date]
    post.updated_at = document[:date]
    post.save
  end
end