type StatusCode = '200' | '403'
type Method = 'get' | 'post'

type Responses = {
    [statusCode in StatusCode]?: {
        description: string
        schema: {
            type: string | Record<string, unknown>
        }
    }
}

interface MethodConfig {
    summary: string
    operationId: string
    'x-google-backend'?: {
        address: string
    }
    responses: Responses
}

export type EndpointConfig = {
    [method in Method]?: MethodConfig
}
