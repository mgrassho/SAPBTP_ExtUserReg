function _dumpCaughtError(error) {
    const responseError = error.response && error.response.data;
    if (responseError) {
        console.debug(error.response);
        console.debug(error.response.data);
    }
    console.error(error.message);
}
exports._dumpCaughtError = _dumpCaughtError;
