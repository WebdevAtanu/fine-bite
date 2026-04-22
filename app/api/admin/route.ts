import { adminService } from "@/features/admin/services/admin.service";
import * as responseHelper from "@/lib/response.helper";

export async function GET() {
  const admins = await adminService.getAll();
  if (admins.length > 0) {
    return responseHelper.successResponse(admins, "Admins found");
  }
  return responseHelper.successNoData("Admins not found");
}

export async function POST(request: Request) {
  const body = await request.json(); // get the request body
  const response = await adminService.createAdmin(body);
  if (response.data) {
    return responseHelper.successResponse(response.data, "Admin created");
  }
  return responseHelper.errorResponse(response.message);
}
