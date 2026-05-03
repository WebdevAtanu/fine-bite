export interface MenuInterface {
  menuId: string;
  menuName: string;
  menuIcon: string;
  type: string;
  isActive: boolean;
}

export type MenuGroupedType = Record<string, MenuInterface[]>; // Record<key, value>
