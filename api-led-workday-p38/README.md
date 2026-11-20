# API-led connectivity migration — Workday Contingent Worker to P38

This directory contains one Mule 4 System API. Flow names follow the supplied TIBCO event-handler names.

```text
Workday file directory
  → HRSystemSealAndCores-Workday_root\SEAL\HRSystem\InterfaceImpl\_AllInstances\FromWorkday\_GenericFilePoller\FileSequencer.process
  → Roche.Pharma.CrossDomain.OP.Workday.FileSequencer.AMM-SRC.ProcessFile.Publication
  → JmsFilePoller.process or JmsPriorityFilePoller.process
  → Roche.Pharma.CrossDomain.OP.Workday.ContingentWorker.AMM-SRC.Create.Publication
  → HRSystemSealAndCores-Workday_root\SEAL\HRSystem\InterfaceImpl\_AllInstances\FromWorkday\ContingentWorker\processFile.process
  → Roche.Pharma.CrossDomain.OP.Workday.ContingentWorker.CMM-SRC.Create.Publication
  → HRSystem Core EventHandler.process
  → Roche.Pharma.CrossDomain.OP.Workday.ContingentWorker.CMM.Create.Publication
  → P38 MRP Core EventHandler.process
  → Roche.Pharma.CrossDomain.OP.P38.ContingentWorker.CMM-DST.Create.Publication
  → P38 SAP EventHandler.process → Create File
```

`ContingentWorker/processFile.process` is a local subflow without a listener. The System API owns all filesystem, JMS, HUB/Oracle, and CHRIS filesystem connectivity.

Set JMS, database, directory, and deployment properties for the System API. The TIBCO export does not contain resolved deployment values, so defaults remain placeholders.

The original single-application migration remains under `../mulesoft-workday-p38-contingent-worker` as a traceable reference implementation.
