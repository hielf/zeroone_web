json.carousels do
  json.array! @carousels do |carousel|
    json.id       carousel.id
    json.url      carousel.first.url ? "http://121.42.36.163" + carousel.first.url : ""
    json.link_to  carousel.second
  end
end
