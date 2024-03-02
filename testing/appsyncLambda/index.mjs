import { DynamoDBClient } from "@aws-sdk/client-dynamodb";
import {
  DynamoDBDocumentClient,
  PutCommand,
  GetCommand,
} from "@aws-sdk/lib-dynamodb";

// Create the DynamoDB client
const client = new DynamoDBClient({});
const docClient = DynamoDBDocumentClient.from(client);

const tableName = "TestTable-Manual";

export async function handler(event) {
  console.log("Received event:", JSON.stringify(event, null, 2));

  switch (event.field) {
    case "makeUser":
      const putCommand = new PutCommand({
        TableName: tableName,
        Item: event.arguments.userDetails,
      });
      await docClient.send(putCommand);
      return event.arguments.userDetails;
    case "getUser":
      const getCommand = new GetCommand({
        TableName: tableName,
        Key: { userId: event.arguments.userId },
      });
      const response = await docClient.send(getCommand);
      return response.Item;
    default:
      throw new Error("Operation not supported");
  }
}
