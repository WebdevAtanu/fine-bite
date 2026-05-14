import React from 'react'
import {
    Select,
    SelectContent,
    SelectGroup,
    SelectItem,
    SelectTrigger,
    SelectValue,
} from "@/components/ui/select"

type CustomSelectPropType = {
    label: string;
    data: string[];
    placeholder?: string;
    value: string;
    setValue: React.Dispatch<React.SetStateAction<string>>;
};

function CustomSelect({ label, data, placeholder, value, setValue }: CustomSelectPropType) {
    return (
        <div className='mt-1'>
            <p className='mb-2'>{label}</p>
            <Select value={value} onValueChange={setValue}>
                <SelectTrigger className="w-full">
                    <SelectValue placeholder={placeholder} />
                </SelectTrigger>
                <SelectContent>
                    <SelectGroup>
                        {data?.map((item) => (
                            <SelectItem key={item} value={item}>
                                {item}
                            </SelectItem>
                        ))}
                    </SelectGroup>
                </SelectContent>
            </Select>
        </div>
    )
}

export default CustomSelect