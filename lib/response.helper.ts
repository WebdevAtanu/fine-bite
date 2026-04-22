import { NextResponse } from "next/server";

// Success with data
export function successResponse<T>(
  data: T,
  message: string = "Success",
  status: number = 200,
) {
  return NextResponse.json(
    {
      success: true,
      message,
      data,
    },
    { status },
  );
}

// Success without data
export function successNoData(
  message: string = "Success",
  status: number = 404,
) {
  return NextResponse.json(
    {
      success: false,
      message,
    },
    { status },
  );
}

// Error response (standardized)
export function errorResponse(
  message: string = "Internal Server Error",
  status: number = 500,
  errors?: unknown,
) {
  return NextResponse.json(
    {
      success: false,
      message,
      errors, // optional (validation errors etc.)
    },
    { status },
  );
}
