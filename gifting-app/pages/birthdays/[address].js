import {useRouter} from 'next/router'

export default function Birthday() {
	const router = useRouter()
	const {address} = router.query
	return <h1> Hello {address} </h1>
}