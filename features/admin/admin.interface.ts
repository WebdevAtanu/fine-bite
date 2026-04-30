export interface AdminInterface {
  adminName: string;
  email: string;
  mobile: string;
  password: string;
  isActive: boolean;
}

export interface AdminLoginInterface {
  email: string;
  password: string;
}