def stub_start_url_200
  stub_request(:get, "https://www.test.host/images").
    to_return(:status => 200, :body => load_fixrute("start_page.html"), :headers => {})
end

def stub_start_url_502
  stub_request(:get, "https://www.badtest.host/images").
    to_return(:status => 502, :body => "Bad Request", :headers => {})
end

def stub_download_file_200
  stub_request(:get, "http://www.test.host/image.png").
    to_return(:status => 200, :body => load_fixrute("test.png"), :headers => {})
end

def stub_download_files_list_200
  [
    "https://www.test.host/textinputassistant/tia.png",
    "https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcTypAzYv6gq-HXsISwPKw5DxRQu6XDW0Aavz0MEcInVrXbRk1sHxAA7ZIA",
    "https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcTm53iZlJ6gf4hkPbYsIJ0gxJ8O8mLQQiBjwjR4Tjwlqj2hMrd837boWT5d",
    "https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcT6JegFLqwz-7iAwyFWqI1DyQJH_MitAWTxVKPas1ojgQOD5vCyBnBCoCQ",
    "https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcT2kKEQ8mJ2t3zn1SHqKgHGcAoKgy2P2wKNnrqul1q5wZJjx8qCdJM2jLw",
    "https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcQ8u6gEaLn0ksg61qRisSAAzCrFdoPIqAtF2TVvgfrZ___jtIvffrbh6Ojy",
    "https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcSCEtj8y9cEYZqkuuwQDwItsTseias3qXaIh5hZ9gmvhWugcK7XK17J6_Sj",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQPOktTUj-Gm_aQ-RKarfBvnWr1xy88MzYtn9UzNJPsVRGOKJ2-Uxw6Ef15",
    "https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcQuvuj9E3XGbYtIEIn5fIW1X_xTAK22nL6t_kV8hUkMaLKBg4nMqt4K",
    "https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcRJleIdVp0n6zuxZAVvkJKPSVQFzomsAr140Rju-vIyE5HauoGJdVg4B7M",
    "https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcRAZyKnkd05bi3aS5uyxJ2VpjX0qjLxpgKWlZD1pFHTjVINf6O33OjTwItQ",
    "https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcRYZLLeqcuCD650Lb3HrLCpZ3xQgac5GQKvUPrXIATLyoDd3xrqfyiezTk",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQD08zSp6NuGMyZnWopL9lWSwEfFllXmjUvowgD_-DUqP5OzltMrBF7JaXQ",
    "https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcQo4LsLQqBfgF4BjgLCSrT_UvJMMRneoDawyHpU9mk5TW6b2eo7cYsAU8jj",
    "https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcT1BhgrXHSpTdy4AP_IvgAXUo_Tsss499TY-drDTktzI2i6ZbAYGrbVss6S",
    "https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcRBbaG3xUcm5HwkzFool2LlgshO2IbtBy5fap8AzGsHpeFtcdbRzZ5MOfI",
    "https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcRFaSFduzqbaVzZN4ZevNZFtyHjfafP3k5p17msj-Zvtbrf9eXn0Atp16A",
    "https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcTqv-FgKLHb5RjSCILe6zzuyg1xrecrHZsrLz0wQ_pRUv6JkKLgWpedVZTO",
    "https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcQFe9Y456thdlwesOwX9Gwp5nk4-0x1JYsFP5HSX6aK6_mm2pWccleEPLR9",
    "https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcR1yz91kLuR0zkKm1P8Df-1RJQ7nqZkQSCQ30F1_MIPbiMsKDo0YKnBpJc",
    "https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcTo_Hs0UKab5CfbOq4A4iQiZNgHLZeb4_sNfHPJdP599pcW0LvbncejJtYb"
  ].each do |url|
    stub_request(:get, url).
      to_return(:status => 200, :body => load_fixrute("test.png"), :headers => {})
  end
end
