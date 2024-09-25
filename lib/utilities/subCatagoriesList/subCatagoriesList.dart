List<String> mobilePhonesSubCatagories = [
  "Mobiles",
  "Mobile Accessories",
  "Smart Watches",
  "Tablets",
  "Laptops"
];

List<String> vehiclesSubCatagories = [
  "Cars",
  "Cars Accessories",
  "Buses and Vans",
  "Rickshaw and Chingchi",
  "Tractors",
  "Boats"
];

List<String> bikesSubCatagories = [
  "Motorcycles",
  "Bicycles",
  "Scooters",
  "Spare Parts"
];

List<String> electronicsSubCatagories = [
  "Computers and Accessories",
  "TV",
  "AC and Coolers",
  "Cameras and Accessories",
  "Fridge and Freezers",
  "Washing Machines and Dryers",
  "Generator, UPS, Power Solution",
  "Other Home and Office Appliances"
];

List<String> furnituresSubCatagories = [
  "Beds",
  "Tables",
  "Sofas and Sofa Beds",
  "Chairs",
  "Mattresses",
  "Mirrors",
  "Office Sofa",
  "Office Tables",
  "Kitchen Cabinets"
];

List<String> nullList = [];

List<String> getSubCatagories(String subCatagory) {
  if (subCatagory == "Mobile Phones") {
    return mobilePhonesSubCatagories;
  } else if (subCatagory == "Vechicles") {
    return vehiclesSubCatagories;
  } else if (subCatagory == "Bikes") {
    return bikesSubCatagories;
  } else if (subCatagory == "Electronics") {
    return electronicsSubCatagories;
  } else if (subCatagory == "Furnitures") {
    return furnituresSubCatagories;
  } else {
    return nullList;
  }
}
