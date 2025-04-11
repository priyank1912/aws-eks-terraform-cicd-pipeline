import { RDSClient } from "@aws-sdk/client-rds";
import { SecretsManagerClient } from "@aws-sdk/client-secrets-manager";


// Define TypeScript types for config
interface AwsCredentials {
  accessKeyId: string;
  secretAccessKey: string;
}

interface AwsConfig {
  region: string;
  credentials: AwsCredentials;
}

interface DbConfig {
  host: string;
  port: number;
  database: string;
  user: string;
}

// AWS Configuration
const awsConfig: AwsConfig = {
  region: import.meta.env.VITE_AWS_REGION || "us-east-1",
  credentials: {
    accessKeyId: import.meta.env.VITE_AWS_ACCESS_KEY_ID || "",
    secretAccessKey: import.meta.env.VITE_AWS_SECRET_ACCESS_KEY || ""
  }
};

// AWS clients
export const rdsClient = new RDSClient(awsConfig);
export const secretsManagerClient = new SecretsManagerClient(awsConfig);

// Database configuration
export const dbConfig: DbConfig = {
  host: import.meta.env.VITE_DB_HOST || "",
  port: Number(import.meta.env.VITE_DB_PORT) || 5432,
  database: import.meta.env.VITE_DB_NAME || "",
  user: import.meta.env.VITE_DB_USER || ""
};

export default awsConfig;
