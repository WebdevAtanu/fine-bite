import jwt from "jsonwebtoken";

const secret: string = process.env.JWT_SECRET || "secret";

export function generateToken(payload: object) {
  return jwt.sign(payload, secret, {
    expiresIn: "1d",
  });
}

export function verifyToken(token: string) {
  return jwt.verify(token, secret);
}

export function decodeToken(token: string) {
  return jwt.decode(token);
}
