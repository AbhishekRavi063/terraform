import { DynamoDBClient } from "@aws-sdk/client-dynamodb";
import {
  DynamoDBDocumentClient,
  PutCommand,
} from "@aws-sdk/lib-dynamodb";

const client = new DynamoDBClient({});
const docClient = DynamoDBDocumentClient.from(client);

const tableName = "BuisnessDetails";

export async function handler(event) {
  console.log("Received event:", JSON.stringify(event, null, 2));

  const putCommand = new PutCommand({
    TableName: tableName,
    Item: {
      businessId: event.arguments.businessId,
      name: event.arguments.name,
      phone: event.arguments.phone,
      mail: event.arguments.mail,
      services: event.arguments.services
    },
  });

  await docClient.send(putCommand);

  return {
    businessId: event.arguments.businessId,
    name: event.arguments.name,
    phone: event.arguments.phone,
    mail: event.arguments.mail,
    services: event.arguments.services
  };
}
