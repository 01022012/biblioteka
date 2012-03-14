require 'net/http'

class GoogleBooksClient
    
  def self.get(isbn)
    parse(fetch(normalize_isbn(isbn)))
  end
  
  def self.normalize_isbn(isbn)
    isbn = isbn.gsub(/ |-/, "")
    if isbn =~ /^ISBN.*/
      return isbn
    else
      return "ISBN#{isbn}"
    end
  end
  
  def self.parse(response)
    result = ActiveSupport::JSON.decode(response)
    if result["totalItems"] > 0
      item = result["items"].first
      volume_info = item["volumeInfo"]
      image_links = volume_info["imageLinks"] || {}
      return Book.new(title: volume_info["title"],
                      description: volume_info["description"],
                      authors: volume_info["authors"].join(", "),
                      isbn: volume_info["industryIdentifiers"][0]["identifier"],
                      cover_url: image_links["thumbnail"])
    else
      return nil
    end
  end
  
  def self.fetch(isbn)
    Net::HTTP.start('www.googleapis.com', 443, use_ssl: true) do |http|
      request = Net::HTTP::Get.new("/books/v1/volumes?q=#{isbn}")
      http.request(request).body
    end
  end
  
end
