import { GetSecretValueCommand } from "@aws-sdk/client-secrets-manager";
import { secretsManagerClient } from "./awsConfig";
import axios from "axios";

// Interface for form data (generic object of strings)
interface FormData {
  [key: string]: string;
}
const API_BASE_URL = "http://backend-service:80/api";

export const saveUser = async (user: { username: string; email: string }) => {
  const response = await fetch(`http://backend-service:80/api/save-user`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify(user),
  });

  if (!response.ok) {
    throw new Error("Failed to save user");
  }

  return await response.json();
};

class DatabaseService {
  private dbPassword: string | null = null;

  // Get password from AWS Secrets Manager
  async getDatabasePassword(): Promise<string> {
    if (!this.dbPassword) {
      try {
        const secretId = import.meta.env.VITE_DB_SECRET_NAME;
        if (!secretId) {
          throw new Error("VITE_DB_SECRET_NAME is not defined in the environment");
        }

        const command = new GetSecretValueCommand({ SecretId: secretId });
        const response = await secretsManagerClient.send(command);
        const secretString = response.SecretString ?? "{}";
        this.dbPassword = JSON.parse(secretString).password;
      } catch (error) {
        console.error("Error retrieving database password:", error);
        throw error;
      }
    }
    if (!this.dbPassword) {
      throw new Error("Database password is not available");
    }
    return this.dbPassword;
  }

  // Save form data (simulate backend call)
  async saveFormData(formData: FormData): Promise<any> {
    try {
      const response = await axios.post("http://backend-service:80/api/save-data", {
        ...formData,
        timestamp: new Date().toISOString()
      });
      return response.data;
    } catch (error) {
      console.error("Error saving form data:", error);
      throw error;
    }
  }
}

export default new DatabaseService();
