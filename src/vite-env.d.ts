interface ImportMetaEnv {
    readonly VITE_AWS_REGION: string;
    readonly VITE_AWS_ACCESS_KEY_ID: string;
    readonly VITE_AWS_SECRET_ACCESS_KEY: string;
    readonly VITE_DB_HOST: string;
    readonly VITE_DB_PORT: string;
    readonly VITE_DB_NAME: string;
    readonly VITE_DB_USER: string;
    readonly VITE_DB_SECRET_NAME: string;
  }
  
  interface ImportMeta {
    readonly env: ImportMetaEnv;
  }
  