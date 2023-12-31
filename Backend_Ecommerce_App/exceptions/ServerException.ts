class ServerException extends Error {
    status: number;
    message: string;
    constructor() {
      super('Error Occurred');
    }
  }
  
  export default ServerException;
  