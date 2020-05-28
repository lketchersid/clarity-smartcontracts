# Clarity Smart Contracts for Workflow Automation

Various smart contracts written in Clarity to prototype tying tasks from multiple blockchains together in a workflow

## Task and sub-task status for workflow in Clarity 

Prototype for simulating change in a workflow's task or sub-task status

- Typically task and sub-task status is kept in our workflow object model, but this will simulate it as we add the ability to exchange STX for tasks.
- Task status can have one of several states:
-- not used
-- not started
-- in process
-- completed
-- cancelled
- Once a task is completed or cancelled it should not be able to be acted upon

Smart Contract: contracts/TaskStatus.clar
Test: test/taskstatus.ts

## Workflow tasks with status and timestamps from STX Blockchain
 
 In Progress

Smart Contract: contracts/TaskStatusWTimeStamps.clar
Test: test/taskstatuswtimestamps.ts

## Author

👤 Larry Ketchersid

- Website: <a href="https://www.mediasourcery.com/">mediasourcery.com</a>
- Personal Website: <a href="https://www.duskbeforethedawn.net/">duskbeforethedawn.net</a>
- Github: [@lketchersid](https://github.com/lketchersid)
