atom_feed :language => 'en-US' do |feed|
  feed.title "Eficode Biblioteka"
  feed.updated @books.first.created_at
              
  @books.each do |book|
    feed.entry book, :published => book.created_at do |entry|
      entry.title book.title
      entry.summary book.description + '<br /><br />Read the full book: <a href="' + book_url(book) + '">' + book_url(book) + '</a><br /><br />', :type => 'html'
      
      entry.author do |author|
        author.name book.authors
      end
    end
  end
end
