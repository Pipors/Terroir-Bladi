import {
  IsString,
  IsNotEmpty,
  IsOptional,
  IsBoolean,
  IsEnum,
  IsDate
} from "class-validator";
import { Role } from "@prisma/client";

type User = {
  id: string
  name: string
  password: string
  firstName: string
  lastName: string
  phone: string
  avatar: string
  role: Enumerator
  isActive: boolean
  preferredLanguage: string
  createdAt: Date
  updatedAt: Date
}

export class CreateUserDTO {


  @IsString()
  @IsOptional()
  id: string

  @IsString()
  @IsNotEmpty()
  email: string

  @IsString()
  @IsNotEmpty()
  password: string

  @IsEnum(Role)
  @IsNotEmpty()
  role: Role

  @IsBoolean()
  @IsOptional()
  isActive: boolean

  @IsString()
  @IsNotEmpty()
  firstName: string

  @IsString()
  @IsNotEmpty()
  lastName: string

  @IsString()
  @IsNotEmpty()
  phone: string

  @IsString()
  @IsOptional()
  avatar: string

  @IsString()
  @IsOptional()
  preferredLanguage: string

  @IsDate()
  @IsOptional()
  createdAt: Date

  @IsDate()
  @IsOptional()
  updatedAt: Date
}