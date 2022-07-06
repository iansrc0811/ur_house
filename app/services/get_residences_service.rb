class GetResidencesService
  require 'open-uri'
  def initialize(city: 'taipei', size: 10)
    raise ArgumentError, 'city is required' if city.blank?
    raise ArgumentError, 'city should be either "taipei" or "new taipei"' if !['taipei', 'new taipei'].include?(city)
    raise ArgumentError, 'size is required and must be an Integer' if size.blank? || !size.is_a?(Integer)
    raise ArgumentError, "size must be >= 1" if size < 1

    @city = city
    @size = size
  end

  def perform
    count = 1
    page = 1
    while count <= @size
      residences = UrHouseCrawler.new(city: @city, page: page).perform
      residences.each do |residence|
        item = Residence.find_or_create_by!(
          title: residence["title"],
          address: residence["search_index"].split(']')[0].delete('['),
          city_id: City.find_by(name: residence["city"]).id,
          district_id: District.find_by(name: residence["dist"]).id,
          price: residence["rent"],
          mrt: residence["mrt_line"],
          room_number: residence["total_room"]
        )
        tempfile = Down.download(residence["image_url"])
        begin
          item.image = tempfile
          item.save!
        ensure
          # delte tempfile
          tempfile.close
          tempfile.unlink
        end
        puts "create residence successfully ##{count}"
        count += 1
        break if count > @size
      rescue StandardError => e
        puts "residence create failed: #{e.message}"
        next
      end
      page += 1
    end
  end
end
