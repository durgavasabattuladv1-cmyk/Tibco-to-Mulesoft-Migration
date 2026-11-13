%dw 2.0
output application/java
var document = payload
---
(document.Contingent_Worker_Events.Worker default []) flatMap ((worker, workerIndex) ->
  (worker.Contingent_Worker_Event default []) map ((event, eventIndex) -> {
    employeeId: worker.Employee_ID default null,
    workerIndex: workerIndex + 1,
    eventIndex: eventIndex + 1,
    event: event
  })
)
