%dw 2.0
output application/java
var source = payload
var event = source.event
var contact = event.Contact_Data default {}
var personnel = (vars.personnelRows default [])[0] default {}
var city = (vars.cityRows default [])[0].ZCITY_KEY default null
fun present(value) = value != null and value != ""
---
{
  employeeId: source.employeeId,
  event: event ++ {
    Contact_Data: (contact - ["Personnel_Area", "Personnel_Subarea", "Working_City"]) ++ {
      (Personnel_Area: personnel.PERSONNEL_AREA) if present(personnel.PERSONNEL_AREA),
      (Personnel_Subarea: personnel.PERSONNEL_SUB_AREA) if present(personnel.PERSONNEL_SUB_AREA),
      (Working_City: city) if present(city)
    }
  }
}
