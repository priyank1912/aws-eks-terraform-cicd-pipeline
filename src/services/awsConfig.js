import { RDSClient } from "@aws-sdk/client-rds";
import { SecretsManagerClient } from "@aws-sdk/client-secrets-manager";

// AWS Configuration
const awsConfig = {
    region: process.env.REACT_APP_AWS_REGION || 'us-east-1',
    credentials: {
        accessKeyId: process.env.REACT_APP_AWS_ACCESS_KEY_ID,
        secretAccessKey: process.env.REACT_APP_AWS_SECRET_ACCESS_KEY
    }
};

// Initialize AWS clients
export const rdsClient = new RDSClient(awsConfig);
export const secretsManagerClient = new SecretsManagerClient(awsConfig);

// Database configuration
export const dbConfig = {
    host: process.env.REACT_APP_DB_HOST,
    port: process.env.REACT_APP_DB_PORT || 5432,
    database: process.env.REACT_APP_DB_NAME,
    user: process.env.REACT_APP_DB_USER,
    // Password will be retrieved from Secrets Manager
};

export default awsConfig; 