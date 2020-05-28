# Clarity Smart Contracts for Workflow Automation

Various smart contracts written in Clarity to prototype tying tasks from multiple blockchains together in a workflow

## Task and sub-task status for workflow in Clarity (Level 0 Clarity Hackathon)

Prototype for simulating change in a workflow's task or sub-task status

- Typically task and sub-task status is kept in our workflow object model, but this will simulate it as we add the ability to exchange STX for tasks.
- Task status can have one of several states:
-- not used
-- not started
-- in process
-- completed
-- cancelled
- Once a task is completed or cancelled it should not be able to be acted upon

Files
- Smart Contract: contracts/TaskStatus.clar
- Test: test/taskstatus.ts

## Workflow tasks with status and timestamps from STX Blockchain (Level 1 Clarity Hackathon)
 
 In Progress

Builds on the Level 0 solution to add in timestamps from the STX Blockchain. This may not be a realistic real-world approach. In the [Clarity docs](https://docs.blockstack.org/core/smart/clarityref) it appears that getting the timestamp in this fashion may not provide enough granularity:
> The time property returns an integer value of the block header time field. This is a Unix epoch timestamp in seconds which roughly corresponds to when the block was mined. Warning: this does not increase monotonically with each block and block times are accurate only to within two hours. See BIP113 for more information.

Files
- Smart Contract: contracts/TaskStatusWTimeStamps.clar
- Test: test/taskstatuswtimestamps.ts

## Integrate with Friedger's Escrow contract for Task Start and Task Complete (Level 2 Clarity Hackathon)

Yeah, yeah...I'll probably run out of time. But it's a project to come back to.

## Author

👤 Larry Ketchersid

- Website: <a href="https://www.mediasourcery.com/">mediasourcery.com</a>
- Personal Website: <a href="https://www.duskbeforethedawn.net/">duskbeforethedawn.net</a>
- Github: [@lketchersid](https://github.com/lketchersid)
