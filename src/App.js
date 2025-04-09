import React, { useState, useEffect } from 'react';
import './App.css';
import databaseService from './services/databaseService';

function App() {
  const [formData, setFormData] = useState({
    field1: '',
    field2: ''
  });
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState(null);
  const [connectionStatus, setConnectionStatus] = useState('checking');

  useEffect(() => {
    // Test database connection on component mount
    const testConnection = async () => {
      try {
        const isConnected = await databaseService.testConnection();
        setConnectionStatus(isConnected ? 'connected' : 'disconnected');
      } catch (err) {
        setConnectionStatus('error');
        setError('Failed to connect to database');
      }
    };
    testConnection();
  }, []);

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData(prevState => ({
      ...prevState,
      [name]: value
    }));
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setIsLoading(true);
    setError(null);

    try {
      await databaseService.saveFormData(formData);
      // Clear form after successful submission
      setFormData({
        field1: '',
        field2: ''
      });
      alert('Data saved successfully!');
    } catch (err) {
      setError('Failed to save data. Please try again.');
      console.error('Form submission error:', err);
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
            disabled={isLoading || connectionStatus !== 'connected'}
          >
            {isLoading ? 'Saving...' : 'Submit'}
          </button>
        </form>
      </div>
    </div>
  );
}

export default App;
