import { IsString, IsNumber, IsBoolean, IsOptional, IsArray, IsDate, IsObject, IsNotEmpty } from 'class-validator';

export class CreateProductDto {
  @IsString()
  @IsNotEmpty()
  sku: string;

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

  @IsNumber()
  @IsNotEmpty()
  price: number;

  @IsOptional()
  @IsNumber()
  originalPrice?: number;

  @IsString()
  @IsNotEmpty()
  currency: string;

  @IsNumber()
  @IsNotEmpty()
  stock: number;

  @IsNumber()
  @IsNotEmpty()
  minStock: number;

  @IsString()
  @IsNotEmpty()
  unit: string;

  @IsOptional()
  @IsNumber()
  weight?: number;

  @IsOptional()
  @IsObject()
  dimensions?: any; // Use an object to match JSONB type

  @IsBoolean()
  @IsNotEmpty()
  isActive: boolean;

  @IsBoolean()
  @IsNotEmpty()
  featured: boolean;

  @IsBoolean()
  @IsNotEmpty()
  bestSeller: boolean;

  @IsBoolean()
  @IsNotEmpty()
  newProduct: boolean;

  @IsBoolean()
  @IsNotEmpty()
  organic: boolean;

  @IsArray()
  @IsNotEmpty()
  tags: string[]; // Use an array to match the JSONB type

  @IsArray()
  @IsNotEmpty()
  specifications: string[]; // Use an array to match the JSONB type

  @IsArray()
  @IsNotEmpty()
  images: string[]; // Use an array to match the JSONB type

  @IsString()
  @IsNotEmpty()
  cooperativeId: string;

  @IsString()
  @IsNotEmpty()
  categoryId: string;

  @IsDate()
  @IsNotEmpty()
  createdAt: Date;

  @IsDate()
  @IsNotEmpty()
  updatedAt: Date;
}
