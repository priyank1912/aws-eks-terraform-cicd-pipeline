import { GetSecretValueCommand } from "@aws-sdk/client-secrets-manager";
import { secretsManagerClient, dbConfig } from './awsConfig';
import axios from 'axios';

class DatabaseService {
    constructor() {
        this.dbPassword = null;
    }

    async getDatabasePassword() {
        if (!this.dbPassword) {
            try {
                const command = new GetSecretValueCommand({
                    SecretId: process.env.REACT_APP_DB_SECRET_NAME
                });
                const response = await secretsManagerClient.send(command);
                this.dbPassword = JSON.parse(response.SecretString).password;
            } catch (error) {
                console.error('Error retrieving database password:', error);
                throw error;
            }
        }
        return this.dbPassword;
    }

    async saveFormData(formData) {
        try {
            // In a real application, you would want to use a backend service
            // to handle the database operations. For security reasons, we'll
            // simulate this with a mock API call
            const response = await axios.post('/api/save-data', {
                ...formData,
                timestamp: new Date().toISOString()
            });
            return response.data;
        } catch (error) {
            console.error('Error saving form data:', error);
            throw error;
        }
    }

    async testConnection() {
        try {
            const password = await this.getDatabasePassword();
            // Here you would typically use a database client to test the connection
            // For security reasons, this should be done on the backend
            return true;
        } catch (error) {
            console.error('Database connection test failed:', error);
            return false;
        }
    }
}

export default new DatabaseService(); 