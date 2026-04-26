import { menuService } from "@/features/menu/menu.service";
import * as responseHelper from "@/lib/responseHelper";

export async function GET() {
  try {
    const menus = await menuService.getAll();
    if (menus.length > 0) {
      return responseHelper.successResponse(menus, "Menus found");
    }
    return responseHelper.successNoData("Menus not found");
  } catch (error: unknown) {
    if (error instanceof Error) {
      return responseHelper.errorResponse(error.message, 500);
    }

    return responseHelper.errorResponse("Something went wrong", 500);
  }
}

export async function POST(request: Request) {
  const body = await request.json(); // get the request body
  const response = await menuService.createMenu(body);
  if (response.data) {
    return responseHelper.successResponse(response.data, "Menu created");
  }
  return responseHelper.errorResponse(response.message);
}
