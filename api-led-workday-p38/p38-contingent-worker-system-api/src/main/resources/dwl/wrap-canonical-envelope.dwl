%dw 2.0
output application/xml writeDeclaration=true, indent=true
ns soap http://schemas.xmlsoap.org/soap/envelope/
ns cmm http://iip.roche.com/cmm/xmlns/2005
---
soap#Envelope: {
  soap#Header: {
    cmm#canonicalMessageHeader: {
      cmm#headerVersion: p('canonical.header.version'),
      cmm#bodyVersion: p('canonical.body.version'),
      cmm#trackingInfo: {
        cmm#eventHandlerInitInfo: {
          cmm#processInfo: {
            cmm#adapterTrackingId: vars.adapterTrackingId,
            cmm#systemName: p('workday.system.id'),
            cmm#componentType: p('workday.component.type'),
            cmm#eventHandlerName: 'workday-contingent-worker-amm-src-flow',
            cmm#topicOfIncomingMessage: p('jms.topic.amm-src')
          }
        }
      }
    }
  },
  soap#Body @("originalFileName": vars.originalFileName): payload
}
