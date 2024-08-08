package co.fieldos.zebra_link_os

interface ResultCallbacksInterface {
    // Callback used the operation is successful.
    fun onSuccess(result: String)

    // Callback used when the operation fails.
    fun onError(error: String)
}
