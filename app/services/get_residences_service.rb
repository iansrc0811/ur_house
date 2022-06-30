class GetResidencesService
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
      residences = UrHouseCrawer.new(city: @city, page: page).perform
      residences.each do |residence|
        begin
          Residence.find_or_create_by!(
            title: residence["title"],
            address:  residence["search_index"].split(']')[0].gsub('[', ''),
            city_id: City.find_by(name: residence["city"]).id,
            district_id: District.find_by(name: residence["dist"]).id,
            price: residence["rent"],
            mrt: residence["mrt_line"],
            room_number: residence["total_room"]
          )
          count += 1
          break if count > @size
        rescue => e
          pusts "residence create failed: #{e.message}"
          next
        end
      end
      page += 1
    end
  end
end
