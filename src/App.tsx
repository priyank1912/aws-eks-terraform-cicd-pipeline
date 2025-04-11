import React, { useState, useEffect, ChangeEvent, FormEvent } from "react";
import "./App.css";
import databaseService from "./services/databaseService";

interface AppFormData {
  field1: string;
  field2: string;
}

const App: React.FC = () => {
  const [formData, setFormData] = useState<AppFormData>({
    field1: "",
    field2: ""
  });
  const [isLoading, setIsLoading] = useState<boolean>(false);
  const [error, setError] = useState<string | null>(null);
  const [connectionStatus, setConnectionStatus] = useState<
    "checking" | "connected" | "disconnected" | "error"
  >("checking");

  useEffect(() => {
    const testConnection = async () => {
      try {
        const isConnected = await databaseService.testConnection();
        setConnectionStatus(isConnected ? "connected" : "disconnected");
      } catch {
        setConnectionStatus("error");
        setError("Failed to connect to database");
      }
    };
    testConnection();
  }, []);

  const handleChange = (e: ChangeEvent<HTMLInputElement>) => {
    const { name, value } = e.target;
    setFormData((prev) => ({
      ...prev,
      [name]: value
    }));
  };

  const handleSubmit = async (e: FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    setIsLoading(true);
    setError(null);

    try {
      await databaseService.saveFormData(formData as any);
      setFormData({ field1: "", field2: "" });
      alert("Data saved successfully!");
    } catch {
      setError("Failed to save data. Please try again.");
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <div className="App">
      <div className="form-container">
        <h1>Data Entry Form</h1>
        <div className={`connection-status ${connectionStatus}`}>
          Database Status: {connectionStatus}
        </div>
        {error && <div className="error-message">{error}</div>}
        <form onSubmit={handleSubmit}>
          <div className="form-group">
            <label htmlFor="field1">Field 1:</label>
            <input
              type="text"
              id="field1"
              name="field1"
              value={formData.field1}
              onChange={handleChange}
              required
              disabled={isLoading}
            />
          </div>
          <div className="form-group">
            <label htmlFor="field2">Field 2:</label>
            <input
              type="text"
              id="field2"
              name="field2"
              value={formData.field2}
              onChange={handleChange}
              required
              disabled={isLoading}
            />
          </div>
          <button
            type="submit"
            className="submit-button"
            disabled={isLoading || connectionStatus !== "connected"}
          >
            {isLoading ? "Saving..." : "Submit"}
          </button>
        </form>
      </div>
    </div>
  );
};

export default App;
