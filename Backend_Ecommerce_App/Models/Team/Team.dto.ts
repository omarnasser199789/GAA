import { Length, IsString, IsNumber } from "class-validator";

class CreateUpdateTeamPersonDTO {
  id: number;
  @IsString()
  name: string;
  kr_name: string;
  @IsString()
  ar_name: string;
  @IsString()
  title: string;
  kr_title: string;
  @IsString()
  ar_title: string;
}

export default CreateUpdateTeamPersonDTO;
