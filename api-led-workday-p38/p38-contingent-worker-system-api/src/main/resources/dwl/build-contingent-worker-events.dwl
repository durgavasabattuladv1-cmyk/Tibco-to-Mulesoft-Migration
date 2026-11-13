%dw 2.0
output application/xml writeDeclaration=true, indent=true
ns wd http://iip.roche.com/schemas/HRSystem/Workday/ContingentWorkerEvent
fun present(value) = value != null and value != ""
fun field(name, value) = {(name): value} if present(value) else {}
fun contact(c) = {
  (wd#Legal_Last_Name: c.Legal_Last_Name) if present(c.Legal_Last_Name),
  (wd#Local_Last_Name: c.Local_Last_Name) if present(c.Local_Last_Name),
  (wd#User_Name: c.User_Name) if present(c.User_Name),
  (wd#Preferred_Last_Name: c.Preferred_Last_Name) if present(c.Preferred_Last_Name),
  (wd#Legal_First_Name: c.Legal_First_Name) if present(c.Legal_First_Name),
  (wd#Local_First_Name: c.Local_First_Name) if present(c.Local_First_Name),
  (wd#Preferred_First_Name: c.Preferred_First_Name) if present(c.Preferred_First_Name),
  (wd#Legal_Name_Country: c.Legal_Name_Country) if present(c.Legal_Name_Country),
  (wd#Suffix: c.Suffix) if present(c.Suffix),
  (wd#Work_Email: c.Work_Email) if present(c.Work_Email),
  (wd#Prefix: c.Prefix) if present(c.Prefix),
  (wd#Salutation: c.Salutation) if present(c.Salutation),
  (wd#Hire_Date: c.Hire_Date) if present(c.Hire_Date),
  (wd#Terminate_Date: c.Terminate_Date) if present(c.Terminate_Date),
  (wd#Last_Date_Worked: c.Last_Date_Worked) if present(c.Last_Date_Worked),
  (wd#Contingent_Worker_Type: c.Contingent_Worker_Type) if present(c.Contingent_Worker_Type),
  (wd#Employee_Group: c.Employee_Group) if present(c.Employee_Group),
  (wd#Employee_Subgroup: c.Employee_Subgroup) if present(c.Employee_Subgroup),
  (wd#Personnel_Area: c.Personnel_Area) if present(c.Personnel_Area),
  (wd#Personnel_Subarea: c.Personnel_Subarea) if present(c.Personnel_Subarea),
  (wd#Action: c.Action) if present(c.Action),
  (wd#Private_Email: c.Private_Email) if present(c.Private_Email),
  (wd#Language: c.Language) if present(c.Language),
  (wd#Working_City: c.Working_City) if present(c.Working_City)
}
fun mappedEvent(e) = {
  wd#Contingent_Worker_Event: {
    wd#Contact_Data: contact(e.Contact_Data default {}),
    (wd#List_Of_Custom_IDs: e.List_Of_Custom_IDs) if e.List_Of_Custom_IDs? ,
    (wd#Phone_Data: e.Phone_Data) if e.Phone_Data?,
    (wd#Contingent_Worker_Data: e.Contingent_Worker_Data) if e.Contingent_Worker_Data?,
    (wd#Additional_Data: e.Additional_Data) if e.Additional_Data?,
    (wd#Biographic_Data: e.Biographic_Data) if e.Biographic_Data?,
    (wd#Position_Data: e.Position_Data) if e.Position_Data?,
    (wd#Event_Name: e.Event_Name) if present(e.Event_Name),
    (wd#Event_Date: e.Event_Date) if present(e.Event_Date)
  }
}
---
wd#Contingent_Worker_Events: {
  (((vars.mappedEvents default []) groupBy $.employeeId) pluck ((events, employeeId) -> {
    wd#Worker: {
      (wd#Employee_ID: employeeId) if present(employeeId),
      (events map ((item) -> mappedEvent(item.event)))
    }
  }))
}
