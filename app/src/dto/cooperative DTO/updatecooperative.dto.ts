import { IsString, 
	IsNumber, 
	IsBoolean, 
	IsOptional, 
	IsDate, 
	IsObject, 
	IsNotEmpty } from 'class-validator';

export class UpdateCooperativetDto {
  @IsString()
  @IsNotEmpty()
  id: string;

  @IsString()
  @IsOptional()
  name_ar: string;

  @IsOptional()
  @IsString()
  name_fr?: string;

  @IsOptional()
  @IsString()
  name_en?: string;

  @IsString()
  @IsOptional()
  description_ar: string;

  @IsOptional()
  @IsString()
  description_fr?: string;

  @IsOptional()
  @IsString()
  description_en?: string;

  @IsString()

  @IsOptional()
  region: string

  @IsString()
  @IsOptional()
  city: string
  
  @IsString()
  @IsOptional()
  address: string

  @IsString()
  @IsOptional()
  phone: string
  
  @IsString()
  @IsOptional()
  email: string

  @IsOptional()
  @IsString()
  website: string

  @IsNumber()
  @IsOptional()
  memberCount: number
  
  @IsOptional()
  @IsString()
  licenseNumber: string

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

}
