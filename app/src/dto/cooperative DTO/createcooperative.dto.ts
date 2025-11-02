import { IsString, IsNumber, IsBoolean, IsOptional, IsArray, IsDate, IsObject, IsNotEmpty, IsAlpha } from 'class-validator';

export class CreateCooperativetDto {
  @IsString()
  id: string
  
  @IsString()
  @IsNotEmpty()
  userId: string;

  @IsString()
  @IsNotEmpty()
  name_ar: string;

  @IsOptional()
  @IsString()
  name_fr?: string;

  @IsOptional()
  @IsString()
  name_en?: string;

  @IsString()
  @IsNotEmpty()
  description_ar: string;

  @IsOptional()
  @IsString()
  description_fr?: string;

  @IsOptional()
  @IsString()
  description_en?: string;

  @IsString()

  @IsNotEmpty()
  region: string

  @IsString()
  @IsNotEmpty()
  city: string
  
  @IsString()
  @IsOptional()
  address: string

  @IsString()
  @IsNotEmpty()
  phone: string
  
  @IsString()
  @IsNotEmpty()
  email: string

  @IsOptional()
  @IsString()
  website: string
  
  @IsNumber()
  @IsNotEmpty()
  establishedYear: number

  @IsNumber()
  @IsNotEmpty()
  memberCount: number
  
  @IsOptional()
  @IsString()
  licenseNumber: string
  
  @IsBoolean()
  @IsNotEmpty()
  isVerified: boolean    
  
  @IsBoolean()
  @IsNotEmpty()
  isActive: boolean

  @IsString()
  @IsOptional()
  logo: string
  
  @IsString()
  @IsOptional()
  coverImage: string  

  @IsObject()
  @IsOptional()
  specialties: Record<string, any>
  
  @IsObject()
  @IsOptional()
  certifications: Record<string, any>

  @IsDate()
  @IsNotEmpty()
  createdAt: Date;

  @IsDate()
  @IsNotEmpty()
  updatedAt: Date;
}
