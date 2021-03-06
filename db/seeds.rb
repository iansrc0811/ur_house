taipei = City.find_or_create_by!(name: "台北市")
new_taipei = City.find_or_create_by!(name: "新北市")

['士林區', '大同區', '大安區', '中山區', '中正區', '內湖區', '文山區', '北投區', '松山區', '信義區', '南港區', '萬華區'].each do |dist|
  taipei.districts.find_or_create_by!(name: dist)
end

['板橋區', '三重區', '中和區', '永和區', '新莊區', '新店區', '土城區', '蘆洲區', '汐止區', '樹林區', '鶯歌區', '三峽區', '淡水區', '瑞芳區', '五股區', '泰山區', '林口區',
 '八里區', '深坑區', '石碇區', '坪林區', '三芝區', '石門區', '金山區', '萬里區', '平溪區', '雙溪區', '貢寮區', '烏來區'].each do |dist|
  new_taipei.districts.find_or_create_by!(name: dist)
end

user = User.find_or_create_by!(email: 'ian@test.com', first_name: 'ian', last_name: 'test')
user.update!(password: '123456')
user = User.find_or_create_by!(email: 'user@test.com', first_name: 'user1', last_name: 'test')
user.update!(password: '123456')
user = User.find_or_create_by!(email: 'user2@test.com', first_name: 'user2', last_name: 'test')
user.update!(password: '123456')
admin = User.find_or_create_by!(email: 'admin@test.com', admin: true, first_name: 'admin', last_name: 'test')
admin.update!(password: '123456')

GetResidencesService.new(city: 'taipei', size: 15).perform
GetResidencesService.new(city: 'new taipei', size: 15).perform
