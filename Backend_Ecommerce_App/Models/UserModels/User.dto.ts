import { Length, IsString } from "class-validator";

class CreateUserDto {
  id:number;
  uid: string;
  fcmToken: string;
  phoneNumber: string;
}


export default CreateUserDto;
