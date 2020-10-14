/**
 * @file Response.hpp
 *
 * @brief Data structure to be used to respond to a request
*/
#ifndef RESPONSE_HPP
#define RESPONSE_HPP

// SYSTEM INCLUDES
#include <stdint.h>
#include <string>

namespace Common
{

/**
 * @enum ResponseCode
 *
 * @brief Codes that will be used when the server
 * response back from a request
 *
 * @li System wide: 0 - 31
 *
*/
enum class ResponseCode : uint8_t
{
    SUCCESS = 0,
    ERROR = 1
};

/**
 * @class Response
 *
 * @brief Structure used to hold response code and
 * any additional information for the response
*/
class Response
{
public:
    /**
     * @brief Constructs a new Response object
    */
    Response(ResponseCode respCode, std::string data) :
        m_respCode(respCode),
        m_data(data)
    {}

    Response() :
        Response(ResponseCode::ERROR, "")
    {}

    explicit Response(ResponseCode respCode) :
        Response(respCode, "")
    {}

    /**
     * @brief Sets the response code member
    */
    void SetResponseCode(const ResponseCode respCode) { m_respCode = respCode; }

    /**
     * @brief Gets the response code member
    */
    ResponseCode GetResponseCode() const { return m_respCode; }

    /**
     * @brief Sets the data string member
    */
    void SetData(const std::string data) { m_data = data; }

    /**
     * @brief Writes data to the data string member
    */
    void AppendData(const std::string& rData)
    {
        if (m_data == "")
        {
            m_data = rData;
        }
        else
        {
            m_data += " " + rData;
        }
    }

    /**
     * @brief Converts the object to a single string
    */
    std::string ToString()
    {
        if (m_data == "")
        {
            return std::to_string(static_cast<uint8_t>(m_respCode));
        }
        else
        {
            return std::to_string(static_cast<uint8_t>(m_respCode)) + " " + m_data;
        }
    }

protected:
private:
    /// Response code associated with the response
    ResponseCode m_respCode;

    /// Data to go along with the response
    std::string m_data;
};

} // namespace Common

#endif // RESPONSE_HPP
