import React from "react";

import {
  Field,
  FieldDescription,
  FieldLabel,
} from "@/components/ui/field";

import { Input } from "@/components/ui/input";

type CustomInputPropType = {
  label: string;
  id: string;
  type?: string;
  placeholder?: string;
  value: string;
  setValue: React.Dispatch<React.SetStateAction<string>>;
};

export function CustomInput({
  label,
  id,
  type = "text",
  placeholder,
  value,
  setValue,
}: CustomInputPropType) {
  return (
    <Field className="mt-1">
      <FieldLabel htmlFor={id}>{label}</FieldLabel>

      <Input
        id={id}
        type={type}
        placeholder={placeholder}
        value={value}
        onChange={(e) => setValue(e.target.value)}
      />
    </Field>
  );
}