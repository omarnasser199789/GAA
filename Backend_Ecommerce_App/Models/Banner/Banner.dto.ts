import { IsString, IsBoolean, IsOptional } from "class-validator";

class CreateUpdateDTO {
  id: number;

  @IsString()
  appName: string;
}

export default CreateUpdateDTO;
