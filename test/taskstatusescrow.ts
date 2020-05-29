import { Client, Provider, ProviderRegistry, Result } from "@blockstack/clarity";
import { assert } from "chai";

describe("task status with escrow contract test suite", () => {
  let taskStatusClient: Client;
  let provider: Provider;

  before(async () => {
    provider = await ProviderRegistry.createProvider();
    taskStatusClient = new Client("SP3GWX3NE58KXHESRYE4DYQ1S31PQJTCRXB3PE9SB.taskstatusescrow", "taskstatusescrow", provider);
  });

  it("should have a valid syntax", async () => {
    await taskStatusClient.checkContract();
  });

  describe("deploying an instance of the contract", () => {
    before(async () => {
      await taskStatusClient.deployContract();
    });

    it("should return initial task status list", async () => {
      const query = taskStatusClient.createQuery({ method: { name: "get-task-status", args: [] } });
      const returns = await taskStatusClient.submitQuery(query);
      const result = Result.unwrap(returns);
      assert.equal(result, "(tuple (cancelled false) (complete false) (inprocess false) (notstarted false) (notused true))");
    });


    it("should return task duration", async () => {
      const query = taskStatusClient.createQuery({ method: { name: "get-task-duration", args: [] } });
      const returns = await taskStatusClient.submitQuery(query);
      const result = Result.unwrap(returns);
      assert.equal(result, "(ok u0)");
    });

    it("should return changed task status list", async () => {
      const initialQuery = taskStatusClient.createQuery({
        method: { name: "task-complete", args: [] }
      });
      const initialReceipt = await taskStatusClient.submitQuery(initialQuery);
      const initialResult = Result.unwrap(initialReceipt);
      console.log(initialResult);

      const query = taskStatusClient.createQuery({ method: { name: "get-task-status", args: [] } });
      const returns = await taskStatusClient.submitQuery(query);
      const result = Result.unwrap(returns);
      assert.equal(result, "(tuple (cancelled false) (complete true) (inprocess false) (notstarted false) (notused true))");
    });

    it("should fail if task is already complete", async () => {
      const initialQuery = taskStatusClient.createQuery({
        method: { name: "task-complete", args: [] }
      });
      const initialReceipt = await taskStatusClient.submitQuery(initialQuery);
      const initialResult = Result.unwrap(initialReceipt);
      console.log(initialResult);
      const query = taskStatusClient.createQuery({
        method: { name: "start-task", args: [] }
      });
      const returns = await taskStatusClient.submitQuery(query);
      const result = Result.unwrap(returns)
      assert.equal(result, "(ok u0)")
    });

  });

  after(async () => {
    await provider.close();
  });
});