import { Length, IsString } from "class-validator";

class registerDto {
  @Length(1, 250)
  email: string;
  @Length(1, 250)
  Username: string;
  @Length(1, 250)
  uid: string;
  ActiveJWT: string;
  @Length(1, 250)
  phoneNumber: string;
  fcmToken: string;
  Address: string;
  @Length(1, 50)
  IndustryType: string;
}

export default registerDto;
