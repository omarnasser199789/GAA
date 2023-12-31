import { IsString, IsBoolean, IsOptional } from "class-validator";

class CreateUpdateDTO {
  id: number;

  @IsString()
  appName: string;

  @IsString()
  primaryColor: string;

  @IsString()
  baseUrl: string;

  @IsString()
  baseSignalrUrl: string;
}

export default CreateUpdateDTO;
