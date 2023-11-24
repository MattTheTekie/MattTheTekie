import type { ReactNode } from 'react'
import { tv, type VariantProps } from 'tailwind-variants'

const treeList = tv({
  variants: {
    type: {
      main: 'flex flex-col max-w-[18rem] [&>*:first-child]:pt-2 [&>*>*:first-child]:py-2',
      simple: 'flex flex-col pl-4'
    }
  },
  defaultVariants: {
    type: 'simple'
  }
})

type TreeListProps = {
  type?: 'main' | 'simple'
  children?: ReactNode
} & VariantProps<typeof treeList>

export default function TreeList ({
  type,
  children,
  ...props
}: TreeListProps): React.ReactElement {
  return (
    <ul className={treeList({
      type: type ?? 'simple'
    })} {...props}>
      {children}
    </ul>
  )
}