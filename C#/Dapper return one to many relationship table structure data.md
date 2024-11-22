利用dapper查詢資料庫一對一,一對多關聯資料     
假如有「國家-城市-鄉鎮」關聯的資料庫table，例:臺灣-臺北市-信義區 

c# Class:
```Csharp
public class Country{
  public int country_id { get; set; }
  public List<City> city { get; set; }
}
public class City{
  public int city_id { get; set; }
  public int link_country_id { get; set; }
  public List<Area> area { get; set; }
}
public class Area{
  public int area_id { get; set; }
  public int link_city_id { get; set; }
}
```


sql:
```sql
select * from Country country
left join City city on country.country_id=city.link_country_id
left join Area area on city.city_id=area.link_city_id
where country.country_id=@in_coutry_id
```


c#:  

```Csharp
public Country GetCountryInformation(int countryId){
  using (var _connect = new SqlConnection(_connectionString))
  {
    var remainingCountry = new Dictionary<int,Country>();
    var result = await _connect.QueryAsync<Country, City, Area, Country>//Country需在最後再宣告一次
    (sql, (country, city, area) =>
    {
        if (country is null)
        {
            return null;
        }
        Country countryResult = new Country();
        if (!remainingCountry.TryGetValue(country.country_id, out countryResult))
        {
            remainingCountry.Add(country.country_id, countryResult = country);
        }
        countryResult.city ??= new List<City>();
        if (null != city)
        {
            bool thisCityExists = countryResult.city.Exists(resultCity => city.city_id == resultCity.city_id);
            if (!thisCityExists)
            {
                countryResult.city.Add(city);
            }
        }
        if (null != area)
        {
            var relatedCity = countryResult.city.Find(resultCity => area.link_city_id == resultCity.city_id);
            relatedCity.area ??= new List<Area>();
            relatedCity.area.Add(area);
        }
        return countryResult;
    },  
    new { in_coutry_id = countryId },
    splitOn: "city_id,area_id");
  var result_distinct = result.Distinct().FirstOrDefault();
  return result_distinct;
  }
}
```
