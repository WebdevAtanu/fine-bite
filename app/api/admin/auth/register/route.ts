import { adminService } from "@/features/admin/admin.service";
import * as responseHelper from "@/lib/responseHelper";

export async function POST(request: Request) {
  const body = await request.json(); // get the request body
  const response = await adminService.createAdmin(body);
  if (response.data) {
    return responseHelper.successResponse(response.data, "Admin created");
  }
  return responseHelper.errorResponse(response.message);
}
