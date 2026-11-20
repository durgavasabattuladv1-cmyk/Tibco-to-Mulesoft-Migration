%dw 2.0
output application/xml writeDeclaration=true, indent=true
var envelope = read(payload, "application/xml")
---
envelope.Envelope.Body.Contingent_Worker_Events
